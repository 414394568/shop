package com.xxxx.manager.service;

import com.xxxx.manager.pojo.GoodsCategory;
import com.xxxx.manager.vo.GoodsCategoryVo;
import org.springframework.stereotype.Service;

import javax.validation.constraints.Size;
import java.util.List;

public interface GoodsCategoryService {
    /**
     * 商品分类-新增分类-查询所有分类
     * @return
     */
    List<GoodsCategory> selectCategoryTopList();

    /**
     * 商品分类-新增分类-级联查询
     * @param parentId
     * @return
     */
    List<GoodsCategory> selectCategoryByParentId(Short parentId);

    /**
     * 商品分类-新增分类-保存分类
     * @param goodsCategory
     * @return
     */
    int categorySave(GoodsCategory goodsCategory);

    /**
     * 商品分类-列表
     * @return
     */
    List<GoodsCategoryVo> selectCategoryListForView();
}
