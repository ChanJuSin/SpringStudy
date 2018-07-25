package org.zerock.controller;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDAOTest {

	@Inject
	private BoardDAO boardDAOImpl;
	
	private static Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	public void testCreate() throws Exception {
		BoardVO vo = new BoardVO();
		vo.setTitle("테스트용");
		vo.setContent("테스트용");
		vo.setWriter("user00");
		boardDAOImpl.create(vo);
	}
	
	public void testRead() throws Exception {
		logger.info(boardDAOImpl.read(1).toString());
	}
	
	public void testUpdate() throws Exception {
		BoardVO vo = new BoardVO();
		vo.setBno(1);
		vo.setTitle("수정 테스트");
		vo.setContent("수정 테스트");
		boardDAOImpl.update(vo);
	}
	
	public void testDelete() throws Exception {
		boardDAOImpl.delete(1);
	}
	
	public void testListPage() throws Exception {
		int page = 3;
		
		List<BoardVO> list = boardDAOImpl.listPage(page);
		
		for (BoardVO boardVO: list) {
			logger.info(boardVO.getBno() + " : " + boardVO.getTitle());
		}
	}
	
	@Test
	public void testListCriteria() throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(20);
		
		List<BoardVO> list = boardDAOImpl.listCriteria(cri);
		
		for (BoardVO boardVO: list) {
			logger.info(boardVO.getBno() + " : " + boardVO.getTitle());
		}
	}
	
}
