package com.wtwi.fin.member.model.vo;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
 
import javax.crypto.Cipher;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.wtwi.fin.member.model.vo.RSA;
 
/** Client -> Server 데이터 전송간 암호화 기능을 담당 **/
@Controller
public class RSAUtil {
    private static final Logger logger = LoggerFactory.getLogger(RSAUtil.class);
 
    private KeyPairGenerator generator;
    private KeyFactory keyFactory;
    private KeyPair keyPair;
    private Cipher cipher;
 
    public RSAUtil() {
        try {
            generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(1024);
            keyFactory = KeyFactory.getInstance("RSA");
            cipher = Cipher.getInstance("RSA");
        } catch (Exception e) {
            logger.warn("RSAUtil 생성 실패.", e);
        } 
    }
  
    /** 새로운 키값을 가진 RSA 생성
     *  @return vo.other.RSA **/
    public RSA createRSA() {
        RSA rsa = null;
        try {
            keyPair = generator.generateKeyPair();
 
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
            
            // 공개키를 통해서 modulus, exponent가 만들어져 view로 가게 된다.
            RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String modulus = publicSpec.getModulus().toString(16);
            String exponent = publicSpec.getPublicExponent().toString(16);
            rsa = new RSA(privateKey, modulus, exponent);
            
        } catch (Exception e) {
            logger.warn("RSAUtil.createRSA()", e);
        }
        return rsa;
    }
 
    /** 개인키를 이용한 RSA 복호화
     *  @param privateKey session에 저장된 PrivateKey
     *  @param encryptedText 암호화된 문자열 **/
    public String getDecryptText(PrivateKey privateKey, String securedValue) throws Exception {
    	String decryptedValue = "";
		 try{
			Cipher cipher = Cipher.getInstance("RSA");
		   /**
			* 암호화 된 값은 byte 배열이다.
			* 이를 문자열 폼으로 전송하기 위해 16진 문자열(hex)로 변경한다. 
			* 서버측에서도 값을 받을 때 hex 문자열을 받아서 이를 다시 byte 배열로 바꾼 뒤에 복호화 과정을 수행한다.
			*/
			byte[] encryptedBytes = hexToByteArray(securedValue);
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
			decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
		 }catch(Exception e)
		 {
			 System.out.println("decryptRsa Exception Error : "+e.getMessage());
		 }
			return decryptedValue;
    }
 
    // 16진수 문자열을 byte 배열로 변환
    private byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[] {};
        }
 
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
 
}

