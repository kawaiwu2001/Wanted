package com.example.wanted.controller;

import com.example.wanted.model.Labels;
import com.example.wanted.service.LabelsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class LabelsController {
    private final LabelsService labelsService;

    @Autowired
    public LabelsController(LabelsService labelsService) {
        this.labelsService = labelsService;
    }

    @RequestMapping(value = "/labelsList",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    public Labels getLabels(@RequestParam("labelsId")Long labelsId){
        return labelsService.getLabels(labelsId);
    }

}
