package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAOImpl;
	
	@Override
	public void regist(BoardVO board) throws Exception {
		boardDAOImpl.create(board);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return boardDAOImpl.read(bno);
	}

	@Override
	public void modify(BoardVO board) throws Exception {
		boardDAOImpl.update(board);
	}

	@Override
	public void remove(Integer bno) throws Exception {
		boardDAOImpl.delete(bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return boardDAOImpl.listAll();
	}

}
