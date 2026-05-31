package com.cpx.dangdang;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
@MapperScan("com.cpx.dangdang.dao")
public class DangDangApplication {
    public static void main(String[] args) {
        SpringApplication.run(DangDangApplication.class,args);
    }
}
