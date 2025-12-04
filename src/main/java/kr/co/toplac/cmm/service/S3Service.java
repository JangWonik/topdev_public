package kr.co.toplac.cmm.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.HttpMethod;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CreateBucketRequest;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;

/**
 * Naver Cloud Object Storage (S3 호환) 서비스
 * Java 1.7 완벽 호환
 */
@Service
public class S3Service {

    @Autowired
    private AmazonS3 amazonS3;

    @Autowired
    @Qualifier("bucketName")
    private String bucketName;

    /**
     * 파일(PC, MulipartFile)을 직접 네이버 Object 서버에 올리고 url 을 받음
     * @param file
     * @param expireMinutes (최대 7일, 단위 : 분)
     * @return
     * @throws IOException
     */
    public String uploadAndGetPresignedUrl(MultipartFile file, int expireMinutes) throws IOException {
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            originalFilename = "unknown_file";
        }

        String key = "uploads/" + UUID.randomUUID().toString() + "_" + originalFilename;

        // 메타데이터 설정
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(file.getSize());
        String contentType = file.getContentType();
        metadata.setContentType(contentType != null ? contentType : "application/octet-stream");

        // InputStream 자동 닫힘 보장!
        try (InputStream inputStream = file.getInputStream()) {
            amazonS3.putObject(bucketName, key, inputStream, metadata);
        }

        // Presigned URL 생성
        Date expiration = new Date(System.currentTimeMillis() + expireMinutes * 60L * 1000L);
        GeneratePresignedUrlRequest request = new GeneratePresignedUrlRequest(bucketName, key)
                .withMethod(HttpMethod.GET)
                .withExpiration(expiration);

        return amazonS3.generatePresignedUrl(request).toString();
    }

    // ===================================================================
    // 2. 폴더 생성 (버킷 안에 "폴더" 만들기)
    // ===================================================================
    public void createFolder(String folderPath) {
        String key = folderPath.endsWith("/") ? folderPath : folderPath + "/";
        try {
            amazonS3.putObject(bucketName, key, new ByteArrayInputStream(new byte[0]), new ObjectMetadata());
            //System.out.println("폴더 생성 성공: " + key);
        } catch (Exception e) {
            System.err.println("Create Folder Exception : " + e.getMessage());
        }
    }

    // ===================================================================
    // 3. 새 버킷 생성 (전체 NCP에 새 버킷)
    // ===================================================================
    public void createBucket(String newBucketName) {
        try {
            CreateBucketRequest request = new CreateBucketRequest(newBucketName, "kr-standard"); // 서울
            amazonS3.createBucket(request);
            System.out.println("새 버킷 생성 성공: " + newBucketName);
        } catch (Exception e) {
            System.err.println("버킷 생성 실패 (이미 존재하거나 오류): " + e.getMessage());
        }
    }

    // ===================================================================
    // 4. 버킷 존재 여부 확인 (테스트용)
    // ===================================================================
    public boolean doesBucketExist() {
        return amazonS3.doesBucketExistV2(bucketName);
    }
    
    /**
     * 서버에 있는 파일 (filePath 경로) 을 네이버 Object 서버에 업로드 후 URL 을 받음
     * @param filePath
     * @param expireMinutes (최대 7일, 단위 : 분)
     * @return
     * @throws IOException
     */
    public String uploadFileAndGetUrl(String folderPath, String filePath, int expireMinutes) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            throw new FileNotFoundException("Empty File : " + filePath);
        }

        String originalFilename = file.getName();
        //String key = "uploads/" + UUID.randomUUID().toString() + "_" + originalFilename;
        String key = folderPath + UUID.randomUUID().toString() + "_" + originalFilename;
        
        // 1. 업로드
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(file.length());
        metadata.setContentType(getContentType(originalFilename));  // 간단 MIME

        try (InputStream inputStream = new FileInputStream(file)) {
            amazonS3.putObject(bucketName, key, inputStream, metadata);
        }

        // 2. Presigned URL 생성
        Date expiration = new Date(System.currentTimeMillis() + expireMinutes * 60L * 1000L);
        GeneratePresignedUrlRequest request = new GeneratePresignedUrlRequest(bucketName, key)
                .withMethod(HttpMethod.GET)
                .withExpiration(expiration);

        return amazonS3.generatePresignedUrl(request).toString();
    }
    
    private String getContentType(String filename) {
        if (filename == null) return "application/octet-stream";
        String lower = filename.toLowerCase();
        if (lower.endsWith(".pdf")) return "application/pdf";
        if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) return "image/jpeg";
        if (lower.endsWith(".png")) return "image/png";
        if (lower.endsWith(".txt")) return "text/plain";
        if (lower.endsWith(".doc")) return "application/msword";
        if (lower.endsWith(".docx")) return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        return "application/octet-stream";  // 기본값
    }
}
