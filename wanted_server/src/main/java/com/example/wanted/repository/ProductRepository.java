package com.example.wanted.repository;

import com.example.wanted.model.Product;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Qualifier("product")
public interface ProductRepository extends JpaRepository<Product,Long> {


}
