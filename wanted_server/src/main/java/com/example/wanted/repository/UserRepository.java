package com.example.wanted.repository;

import com.example.wanted.model.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("user")
public interface UserRepository extends JpaRepository<User, Integer> {

    @Query("select u from user u where u.name = ?1")
    public User findByName(String name);

    @Query("select u.id from user u where u.name = ?1")
    public Long findIDByName(String name);

    @Query("select u.name from user u where u.id = ?1")
    String getUserName(int userId);
}
