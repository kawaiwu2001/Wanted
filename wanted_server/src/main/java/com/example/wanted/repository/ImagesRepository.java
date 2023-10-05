package com.example.wanted.repository;

import com.example.wanted.model.Images;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("images")
public interface ImagesRepository  extends JpaRepository<Images,Long> {
}
