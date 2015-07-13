package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.constant.SessionKey;
import com.sfbm.ideas.services.front.idea.IdeaService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Controller
@Scope("prototype")
public class IdeasController {
    @Resource
    private IdeaService ideaService;

    @RequestMapping(value="/ideas/add.json", method = RequestMethod.POST)
    public @ResponseBody long doAddIdea(HttpSession session, @RequestParam(required = true) String ideaName, String ideaPicUrl, boolean isPublic) {
        UserCoreInfo userCoreInfo = null;

        if (null != session.getAttribute(SessionKey.USER)) {
            userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);
        }

        IdeaInfo ideaInfo = null;

        try {
            ideaInfo = ideaService.saveIdeaInfo(userCoreInfo.getUserId(), ideaName, ideaPicUrl, isPublic);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (null == ideaInfo) {
            return -1;
        } else {
            return ideaInfo.getIdeaId();
        }
    }




}
