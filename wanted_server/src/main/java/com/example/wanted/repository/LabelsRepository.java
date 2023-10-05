package com.example.wanted.repository;

import com.example.wanted.model.Labels;
import com.example.wanted.model.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("labels")
public interface LabelsRepository  extends JpaRepository<Labels,Long> {


}
