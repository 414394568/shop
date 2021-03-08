package com.xxxx.manager.service.impl;

import com.xxxx.manager.mapper.GoodsCategoryMapper;
import com.xxxx.manager.pojo.GoodsCategory;
import com.xxxx.manager.pojo.GoodsCategoryExample;
import com.xxxx.manager.service.GoodsCategoryService;
import com.xxxx.manager.vo.GoodsCategoryVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class GoodsCategoryServiceImpl implements GoodsCategoryService {
    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;

    /**
     * 商品分类-新增分类-查询所有分类
     * @return
     */
    @Override
    public List<GoodsCategory> selectCategoryTopList() {
        //创建查询对象
        GoodsCategoryExample example = new GoodsCategoryExample();
        //设置查询条件， parent_id = 0
        example.createCriteria().andParentIdEqualTo((short)0);
        List<GoodsCategory> goodsCategorieList = goodsCategoryMapper.selectByExample(example);
        return goodsCategorieList;
    }

    /**
     * 商品分类-新增分类-级联查询
     * @param parentId
     * @return
     */
    @Override
    public List<GoodsCategory> selectCategoryByParentId(Short parentId) {
        GoodsCategoryExample example = new GoodsCategoryExample();
        example.createCriteria().andParentIdEqualTo(parentId);
        return goodsCategoryMapper.selectByExample(example);
    }

    /**
     * 商品分类-新增分类-保存分类
     * @param goodsCategory
     * @return
     */
    @Override
    public int categorySave(GoodsCategory goodsCategory) {
        return goodsCategoryMapper.insertSelective(goodsCategory);
    }

    /**
     * 商品分类-列表
     * @return
     */
    @Override
    public List<GoodsCategoryVo> selectCategoryListForView() {
        GoodsCategoryExample example = new GoodsCategoryExample();
        example.createCriteria().andParentIdEqualTo((short)0).andLevelEqualTo((byte)1);
        //查询顶级分类
        List<GoodsCategory> gcList = goodsCategoryMapper.selectByExample(example);
        List<GoodsCategoryVo> gcvList = new ArrayList<>();
        for (GoodsCategory gc01 : gcList) {
            GoodsCategoryVo gcv01 = new GoodsCategoryVo();
            BeanUtils.copyProperties(gc01,gcv01);
            //清空
            example.clear();
            //设置查询条件
            example.createCriteria().andParentIdEqualTo(gc01.getId()).andLevelEqualTo((byte)2);
            //查询二级分类
            List<GoodsCategory> gcList02 = goodsCategoryMapper.selectByExample(example);
            List<GoodsCategoryVo> gcvList02 = new ArrayList<>();
            for (GoodsCategory gc02 : gcList02) {
                GoodsCategoryVo gcv02 = new GoodsCategoryVo();
                BeanUtils.copyProperties(gc02,gcv02);
                //清空
                example.clear();
                //设置查询条件
                example.createCriteria().andParentIdEqualTo(gc02.getId()).andLevelEqualTo((byte)3);
                //查询三级分类
                List<GoodsCategory> gcList03 = goodsCategoryMapper.selectByExample(example);
                List<GoodsCategoryVo> gcvList03 = new ArrayList<>();
                for (GoodsCategory gc03 : gcList03) {
                    GoodsCategoryVo gcv03 = new GoodsCategoryVo();
                    BeanUtils.copyProperties(gc03,gcv03);
                    gcvList03.add(gcv03);
                }

                gcv02.setChildren(gcvList03);
                gcvList02.add(gcv02);
            }

            //把二级费雷放入以及分类的对象里
            gcv01.setChildren(gcvList02);
            gcvList.add(gcv01);
        }
        return gcvList;
//        //========================JDK8新特性======================
//        //创建查询对象
//        GoodsCategoryExample example = new GoodsCategoryExample();
//        //查询所有商品分类
//        List<GoodsCategory> list = goodsCategoryMapper.selectByExample(example);
//        //将GoodsCategory对象转成GoodsCategoryVo对象
//        List<GoodsCategoryVo> gcvList = list.stream().map(e -> {
//            GoodsCategoryVo gcv = new GoodsCategoryVo();
//            BeanUtils.copyProperties(e, gcv);
//            return gcv;
//        }).collect(Collectors.toList());
//        //将List<GoodsCategoryVo>转成Map<parentId,List<GoodsCategoryVo>>
//        //按parentId分组，key就是parentId,值就是parentId对应的List<GoodsCategoryVo>
//        Map<Short, List<GoodsCategoryVo>> map =
//                gcvList.stream().collect(Collectors.groupingBy(GoodsCategoryVo::getParentId));
//        //循环，给children赋值
//        gcvList.forEach(e->e.setChildren(map.get(e.getId())));
//        //拦截器，返回level为1的list，也就是顶级分类
//        List<GoodsCategoryVo> gcvList01 = gcvList.stream().filter(e -> 1 == e.getLevel()).collect(Collectors.toList());
//        //========================JDK8新特性=======================
//        return gcvList01;
    }
}
