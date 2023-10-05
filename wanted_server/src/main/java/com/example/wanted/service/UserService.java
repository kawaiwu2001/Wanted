package com.example.wanted.service;

import com.example.wanted.model.User;
import com.example.wanted.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    final UserRepository userRepository;

    @Autowired
    public UserService(@Qualifier("user") UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void save(User user){
         userRepository.save(user);
    }



    public User findByName(String name) {
        return userRepository.findByName(name);
    }

    //檢查用戶名是否被使用
    public boolean checkNameUsed(String name){
        if(userRepository.findByName(name) != null){
            return true;
        }else{
            return false;
        }
    }

    //檢查用戶密碼是否正确
    public int checkPasswordUsed(User user){
        User u = userRepository.findByName(user.getName());
        if(u != null){
            if(user.getPassword().equals(u.getPassword())){
                return u.getId();
            }else{
                return -1;
            }
        }else{
            return -1;
        }
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User getUser(int userId) {
        return userRepository.getById(userId);
    }

    public String getUserName(int userId) {
        return userRepository.getUserName(userId);
    }

    public String deleteUser(int userId) {
        if (userRepository.existsById(userId)){
            userRepository.deleteById(userId);
            return "1";
        }else {
            return "-1";
        }
    }
}
