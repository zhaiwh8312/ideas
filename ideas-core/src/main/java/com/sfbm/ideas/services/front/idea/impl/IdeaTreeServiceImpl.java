package com.sfbm.ideas.services.front.idea.impl;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.IdeaNodeInfo;
import com.sfbm.ideas.core.constant.NodeStatus;
import com.sfbm.ideas.core.constant.TreeRootID;
import com.sfbm.ideas.services.front.idea.IdeaTreeService;
import com.sfbm.ideas.services.dao.IdeaInfoDAO;
import com.sfbm.ideas.services.dao.IdeaNodeInfoDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/14.
 */
@Service(value = "ideaTreeService")
public class IdeaTreeServiceImpl implements IdeaTreeService {
    @Resource
    private IdeaInfoDAO ideaInfoDAO;
    @Resource
    private IdeaNodeInfoDAO ideaNodeInfoDAO;

    @Override
    public IdeaNodeInfo saveIdeaNodeInfo(long userId, long ideaId, long parentId, String nodeContent, int xLocation, int yLocation, String nodeColor, String instruction, String linkUrl, String icon) throws Exception {
        IdeaInfo ideaInfo = ideaInfoDAO.queryIdeaInfoByIdeaId(ideaId);

        if (null == ideaInfo || ideaInfo.getUserId() != userId) {
            return null;
        }

        IdeaNodeInfo ideaNodeInfo = new IdeaNodeInfo();

        int count = ideaNodeInfoDAO.queryCountIdeaNodeInfoByIdeaId(ideaId);

        if (count == 0) {
            ideaNodeInfo.setParentNodeId(TreeRootID.ROOT);
        } else {
            ideaNodeInfo.setParentNodeId(parentId);
        }
        ideaNodeInfo.setIdeaId(ideaId);
        ideaNodeInfo.setNodeContent(nodeContent);
        ideaNodeInfo.setxLocation(xLocation);
        ideaNodeInfo.setyLocation(yLocation);
        ideaNodeInfo.setNodeColor(nodeColor);
        ideaNodeInfo.setLinkUrl(linkUrl);
        ideaNodeInfo.setInstruction(instruction);
        ideaNodeInfo.setIcon(icon);
        ideaNodeInfo.setCreateTime(new Date());
        ideaNodeInfo.setStatus(NodeStatus.NORMAL.getName());

        ideaNodeInfoDAO.insertIdeaNodeInfo(ideaNodeInfo);

        if (ideaNodeInfo.getNodeId() == 0) {
            return null;
        }

        return ideaNodeInfo;
    }

    @Override
    public List<IdeaNodeInfo> getIdeaTreeByIdeaId(long ideaId) throws Exception {
        return ideaNodeInfoDAO.queryIdeaNodeInfoByIdeaId(ideaId);
    }

    @Override
    public IdeaNodeInfo modifyIdeaNodeInfoForLocation(long userId, long nodeId, int xLocation, int yLocation) throws Exception {
        IdeaNodeInfo ideaNodeInfo = ideaNodeInfoDAO.queryIdeaNodeInfoByNodeId(nodeId);

        if (null == ideaNodeInfo) {
            return null;
        }

        IdeaInfo ideaInfo = ideaInfoDAO.queryIdeaInfoByIdeaId(ideaNodeInfo.getIdeaId());

        if (null == ideaInfo || ideaInfo.getUserId() != userId) {
            return null;
        }

        ideaNodeInfo.setxLocation(xLocation);
        ideaNodeInfo.setyLocation(yLocation);

        ideaNodeInfoDAO.updateIdeaNodeInfo(ideaNodeInfo);

        return ideaNodeInfo;
    }

    @Override
    public IdeaNodeInfo deleteIdeaNodeInfo(long userId, long nodeId) throws Exception {
        IdeaNodeInfo ideaNodeInfo = ideaNodeInfoDAO.queryIdeaNodeInfoByNodeId(nodeId);

        if (null == ideaNodeInfo) {
            return null;
        }

        IdeaInfo ideaInfo = ideaInfoDAO.queryIdeaInfoByIdeaId(ideaNodeInfo.getIdeaId());

        if (null == ideaInfo || ideaInfo.getUserId() != userId) {
            return null;
        }

        ideaNodeInfo.setStatus(NodeStatus.DELETE.getName());

        ideaNodeInfoDAO.updateIdeaNodeInfo(ideaNodeInfo);

        this.deleteChildrenNode(ideaNodeInfo);

        return ideaNodeInfo;
    }

    /**
     * 删除所有子一级节点
     * @param nodeInfo
     * @throws Exception
     */
    private void deleteChildrenNode(IdeaNodeInfo nodeInfo) throws Exception {
        List<IdeaNodeInfo> childNodeList = ideaNodeInfoDAO.queryIdeaNodeInfoByParentId(nodeInfo.getNodeId());

        for (IdeaNodeInfo childNode : childNodeList) {
            childNode.setStatus(NodeStatus.DELETE.getName());

            ideaNodeInfoDAO.updateIdeaNodeInfo(childNode);

            this.deleteChildrenNode(childNode);
        }
    }
}
