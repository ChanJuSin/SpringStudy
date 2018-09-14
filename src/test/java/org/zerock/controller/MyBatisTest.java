package org.zerock.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MyBatisTest {

	@Inject
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MyBatisTest.class);
	
	@Test
	public void sqlSessionTest() {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", "user00");
		map.put("upw", "user00");
		UserVO userVO = sqlSession.selectOne("org.zerock.mapper.UserMapper.login", map);
		logger.info(userVO.toString());
	}
	
}
