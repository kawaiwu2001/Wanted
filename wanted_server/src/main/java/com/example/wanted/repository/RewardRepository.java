package com.example.wanted.repository;

import com.example.wanted.model.Reward;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("reward")
public interface RewardRepository extends JpaRepository<Reward,Long> {

}
