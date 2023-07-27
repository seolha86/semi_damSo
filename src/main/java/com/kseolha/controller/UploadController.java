package com.kseolha.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.kseolha.domain.AttachFileDTO;
import lombok.Getter;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import net.coobird.thumbnailator.tasks.UnsupportedFormatException;

@Controller
@Log4j
public class UploadController {
    @Getter
    private static final String PATH = "c:/upload/damso";

    @GetMapping("upload")
    public void upload() {
        log.info("upload");
    }

    @GetMapping("uploadAjax")
    public void uploadAjax() {
        log.info("uploadAjax");
    }

    @PostMapping(value="uploadAjax", produces=MediaType.APPLICATION_JSON_VALUE) @ResponseBody
    public List<AttachFileDTO> uploadAjax(MultipartFile[] files) {
        log.info("uploadAjax post");

        File uploadPath = new File(PATH, getFolder());
        if(!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        List<AttachFileDTO> list = new ArrayList<>();
        for(MultipartFile m : files) {
            log.info(m.getOriginalFilename());

            // 실제 스트림 전송
            String uuidStr = UUID.randomUUID().toString();
            String tName = uuidStr + "_" + m.getOriginalFilename();
            File f = new File(uploadPath, tName);
            Boolean image = false;
            try {
                image = isImage(f);
                m.transferTo(f);
                if(image){
                    // 섬네일 처리
                    File f2 = new File(uploadPath, "s_" + tName);
                    Thumbnails.of(f).crop(Positions.CENTER).size(400, 400).toFile(f2);
                }
            } catch (UnsupportedFormatException e) {
                image = false;
            }
            catch (IOException e) {
                e.printStackTrace();
            }
            AttachFileDTO dto = new AttachFileDTO();
            dto.setUuid(uuidStr);
            dto.setPath(getFolder());
            dto.setImage(image);
            dto.setName(m.getOriginalFilename());
            list.add(dto);
        }
        return list;
    }

    @GetMapping("display") @ResponseBody
    public ResponseEntity<byte[]> getFile(AttachFileDTO dto, Boolean thumb) {
        // Boolean을 꼭 기본형이 아닌 클래스를 써야하는 이유는 널처리를 위해선

        // fileName : path + uuid + name -> 파라미터에 String fileName만 넣으면 위험한 이유.
        // AttachFileDTO dto를 추가

//        log.info(dto);
        String s = PATH + "/" + dto.getPath() + "/" + (thumb != null && thumb ? "s_" : "") + dto.getUuid() + "_" + dto.getName();
        File file = new File(s);

//        log.info("exist() : " + file.exists());
//        log.info(thumb);

        ResponseEntity<byte[]> result = null;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
        } catch (IOException e) {
//            e.printStackTrace();
        }
        return result;

    }

    @GetMapping("deleteFile") @ResponseBody
    public String deleteFile(AttachFileDTO dto) {
        String s = PATH + "/" + dto.getPath() + "/" + dto.getUuid() + "_" + dto.getName();
        File file = new File(s);
        file.delete();

        if (dto.isImage()) {
            s = PATH + "/" + dto.getPath() + "/s_" + dto.getUuid() + "_" + dto.getName();
            file = new File(s);
            file.delete();
        }
        return "deleted";
    }

    @GetMapping("download") @ResponseBody
    public ResponseEntity<byte[]> download(AttachFileDTO dto, Boolean thumb) {
        String s = PATH + "/" + dto.getPath() + "/" + dto.getUuid() + "_" + dto.getName();
        File file = new File(s);

        ResponseEntity<byte[]> result = null;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", MediaType.APPLICATION_OCTET_STREAM_VALUE);
            headers.add("Content-Disposition","attachment; filename=" + new String(dto.getName().getBytes("utf-8"), "iso-8859-1"));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }


    private String getFolder() {
        return new SimpleDateFormat("yyyy/MM/dd").format(new Date());
    }

    // 확장자의 다양성 처리 file >> mime
    private boolean isImage(File file) throws IOException {
        List<String> excludes = Arrays.asList("ico", "webp");
        int idx = file.toString().lastIndexOf(".");
        if(idx == -1){
            return false;
        }
        String ext = file.toString().substring(idx+1);
        if(excludes.contains(ext)) {
            return false;
        }

        String mime = Files.probeContentType(file.toPath());
        return mime != null && mime.startsWith("image");
    }

}
