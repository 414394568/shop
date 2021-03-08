package com.xxxx.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {
    @RequestMapping("/{page}")
    public String page(@PathVariable String page){
        System.out.println(page);
        return page;
    }

    @RequestMapping("/")
    public String index(){
        return "index";
    }
}
