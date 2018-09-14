package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAOImpl;

	@Transactional
	@Override
	public void regist(BoardVO board) throws Exception {
		boardDAOImpl.create(board);
		String[] files = board.getFiles();
		if (files == null) { return; }
		for (String fileName: files) {
			boardDAOImpl.addAttach(fileName);
		}
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bno) throws Exception {
		boardDAOImpl.updateViewCnt(bno);
		return boardDAOImpl.read(bno);
	}

	@Transactional
	@Override
	public void modify(BoardVO board) throws Exception {
		boardDAOImpl.update(board);
		
		Integer bno = board.getBno();
		boardDAOImpl.deleteAttach(bno);
		
		String[] files = board.getFiles();
		if (files == null) { return; }
		for (String fileName: files) {
			boardDAOImpl.replaceAttach(fileName, bno);
		}
	}

	@Transactional
	@Override
	public void remove(Integer bno) throws Exception {
		boardDAOImpl.deleteAttach(bno);
		boardDAOImpl.delete(bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return boardDAOImpl.listAll();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return boardDAOImpl.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		return boardDAOImpl.countPaging(cri);
	}

	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return boardDAOImpl.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return boardDAOImpl.listSearchCount(cri);
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		return boardDAOImpl.getAttach(bno);
	}

}
