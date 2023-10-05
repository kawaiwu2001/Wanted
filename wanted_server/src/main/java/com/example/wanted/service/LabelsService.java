package com.example.wanted.service;

import com.example.wanted.model.Labels;
import com.example.wanted.repository.LabelsRepository;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LabelsService {
    private final LabelsRepository labelsRepository;

    public LabelsService(@Qualifier("labels") LabelsRepository labelsRepository) {
        this.labelsRepository = labelsRepository;
    }

    public Labels getLabels(Long labelsId) {
       // Long id = labelsRepository.getByProductId();
        return labelsRepository.findById(labelsId).get();
    }
}
