package com.xxxx.manager;

import com.xxxx.manager.service.GoodsCategoryService;
import com.xxxx.manager.vo.GoodsCategoryVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class GoodCategoryServiceTest {

    @Autowired
    private GoodsCategoryService goodsCategoryService;

    @Test
    public void testSelectCategoryListForView(){
        List<GoodsCategoryVo> gcvList = goodsCategoryService.selectCategoryListForView();
        System.out.println(gcvList);
    }
}
