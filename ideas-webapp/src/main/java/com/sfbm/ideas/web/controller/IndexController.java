package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.IdeaInfo;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 主页
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Controller
@Scope("prototype")
public class IndexController {



    @RequestMapping(value={"/", "/index.html"})
    public ModelAndView doIndex() {
        ModelAndView mav = new ModelAndView();

        mav.setViewName("views/home/index.jsp");

        return mav;
    }
}
