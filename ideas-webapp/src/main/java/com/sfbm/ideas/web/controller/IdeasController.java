package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.core.constant.SessionKey;
import com.sfbm.ideas.services.front.idea.IdeaService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Controller
@Scope("request")
public class IdeasController {
    @Resource
    private IdeaService ideaService;

    @RequestMapping(value="/idea/add.json", method = RequestMethod.POST)
    public @ResponseBody long doAddIdea(HttpSession session, @RequestParam(required = true) String ideaName, String ideaPicUrl, @RequestParam(required = true) boolean isPublic) {
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

    @RequestMapping(value="/idea/public_list.json", method = RequestMethod.POST)
    public @ResponseBody List<IdeaInfo> doGetIdeaList(int offset, int limit) {
        List<IdeaInfo> ideaInfoList = new ArrayList<IdeaInfo>();

        try {
            ideaInfoList = ideaService.getPublicIdeaInfoList(offset, limit);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaInfoList;
    }

    @RequestMapping(value="/idea/info/{ideaId}.json", method = RequestMethod.POST)
    public @ResponseBody IdeaInfo doGetIdeaInfo(HttpSession session, @PathVariable long ideaId) {
        UserCoreInfo userCoreInfo = null;

        if (null != session.getAttribute(SessionKey.USER)) {
            userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);
        }

        IdeaInfo ideaInfo = null;

        try {
            ideaInfo = ideaService.getIdeaInfo(userCoreInfo.getUserId(), ideaId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaInfo;
    }


    @RequestMapping(value="/idea/update.json", method = RequestMethod.POST)
    public @ResponseBody IdeaInfo doUpdateIdea(HttpSession session, @RequestParam(required = true) long ideaId, @RequestParam(required = true) String ideaName, @RequestParam(required = true) boolean isPublic) {
        UserCoreInfo userCoreInfo = null;

        if (null != session.getAttribute(SessionKey.USER)) {
            userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);
        }

        IdeaInfo ideaInfo = null;

        try {
            ideaInfo = ideaService.modifyIdeaInfo(userCoreInfo.getUserId(), ideaId, ideaName, isPublic);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaInfo;
    }

    @RequestMapping(value="/idea/delete.json", method = RequestMethod.POST)
    public @ResponseBody IdeaInfo doDeleteIdea(HttpSession session, @RequestParam(required = true) long ideaId) {
        UserCoreInfo userCoreInfo = null;

        if (null != session.getAttribute(SessionKey.USER)) {
            userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);
        }

        IdeaInfo ideaInfo = null;

        try {
            ideaInfo = ideaService.removeIdeaInfo(userCoreInfo.getUserId(), ideaId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaInfo;
    }

}
