package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.front.test.IDService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/10.
 */
@Controller
@Scope("request")
public class TestController {
    @Resource
    private IDService idService;

    @RequestMapping(value="/test/login.html")
    public @ResponseBody String doIndex() {
        try {
            idService.addTest();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
