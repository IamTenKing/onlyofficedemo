package com.example.onlyofficedemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class OnlyofficedemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(OnlyofficedemoApplication.class, args);
    }

}
