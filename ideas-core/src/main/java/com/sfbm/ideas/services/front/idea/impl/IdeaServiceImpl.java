package com.sfbm.ideas.services.front.idea.impl;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.constant.IdeaStatus;
import com.sfbm.ideas.services.front.idea.IdeaService;
import com.sfbm.ideas.services.front.idea.dao.IdeaInfoDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Service(value = "ideaService")
public class IdeaServiceImpl implements IdeaService {
    @Resource
    private IdeaInfoDAO ideaInfoDAO;

    @Override
    public IdeaInfo getIdeaInfo(long ideaId) throws Exception {
        return ideaInfoDAO.queryIdeaInfoByIdeaId(ideaId);
    }

    @Override
    public IdeaInfo saveIdeaInfo(long userId, String ideaName, String ideaPicUrl, boolean isPublic) throws Exception {
        if (userId <= 0) {
            return null;
        }

        IdeaInfo ideaInfo = new IdeaInfo();

        ideaInfo.setUserId(userId);
        ideaInfo.setIdeaName(ideaName);
        ideaInfo.setIdeaPicUrl(ideaPicUrl);
        ideaInfo.setIsPublic(isPublic);
        ideaInfo.setStatus(IdeaStatus.NORMAL.getName());

        ideaInfoDAO.insertIdeaInfo(ideaInfo);

        return ideaInfo;
    }

    @Override
    public List<IdeaInfo> getPublicIdeaInfoList(int offset, int limit) throws Exception {
        List<IdeaInfo> ideaInfoList = new ArrayList<IdeaInfo>();

        if (limit <= 0) {
            ideaInfoList = ideaInfoDAO.queryIdeaInfoListIsPublic();
        } else {
            ideaInfoList = ideaInfoDAO.queryIdeaInfoListIsPublic(offset, limit);
        }

        return ideaInfoList;
    }



}
