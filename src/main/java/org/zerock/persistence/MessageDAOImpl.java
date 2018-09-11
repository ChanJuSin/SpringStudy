package org.zerock.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.MessageVO;

import javax.inject.Inject;

@Repository
public class MessageDAOImpl implements MessageDAO {
    @Inject
    private SqlSession sqlSession;

    private static String namespace = "org.zerock.mapper.MessageMapper";

    @Override
    public void create(MessageVO vo) throws Exception {
        sqlSession.insert(namespace + ".create", vo);
    }

    @Override
    public MessageVO readMessage(Integer mno) throws Exception {
        return sqlSession.selectOne(namespace + ".readMessage", mno);
    }

    @Override
    public void updateState(Integer mno) throws Exception {
        sqlSession.update(namespace + ".updateState", mno);
    }
}
