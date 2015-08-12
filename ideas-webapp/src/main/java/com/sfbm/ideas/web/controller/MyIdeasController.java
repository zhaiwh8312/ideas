package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.core.constant.SessionKey;
import com.sfbm.ideas.services.front.idea.MyIdeasService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 我的点子
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Controller
@Scope("request")
public class MyIdeasController {
    @Resource
    private MyIdeasService myIdeasService;

    @RequestMapping(value="/myideas/index.html")
    public ModelAndView doInit(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        UserCoreInfo userCoreInfo = null;

        if (null != session.getAttribute(SessionKey.USER)) {
            userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);
        }

        if (null == userCoreInfo) {
            mav.setViewName("redirect:/user/login.html");
        }

        List<IdeaInfo> ideaInfoList = new ArrayList<IdeaInfo>();

        try {
            ideaInfoList = myIdeasService.getMyIdeasList(userCoreInfo.getUserId());
        } catch (Exception e) {
            e.printStackTrace();
        }

        mav.setViewName("views/ideas/my/index.jsp");
        mav.addObject("ideaInfoList", ideaInfoList);

        return mav;
    }
}
