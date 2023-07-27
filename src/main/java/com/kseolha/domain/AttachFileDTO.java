package com.kseolha.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
    private String name;
    private String path;
    private String uuid;
    private boolean image;
}
