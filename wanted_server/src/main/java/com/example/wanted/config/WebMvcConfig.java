package com.example.wanted.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String os = System.getProperty("os.name");
        if (os.toLowerCase().startsWith("win")){
            registry.addResourceHandler("/upload/**")
                    .addResourceLocations("file:D:/wanted/wanted_server/target/classes/static/upload/");
        }else{
            registry.addResourceHandler("/upload/**")
                    .addResourceLocations("classpath:static/upload/");

        }
        //registry.addResourceHandler("/image/**").addResourceLocations("file:D://");
        //registry.addResourceHandler("/image/**").addResourceLocations("/");

    }
}


