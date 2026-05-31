package com.cpx.dangdang.controller;

import com.cpx.dangdang.entity.Address;
import com.cpx.dangdang.entity.User;
import com.cpx.dangdang.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("address")
public class AddressController {
    @Autowired
    private AddressService addressService;

    @RequestMapping("show")
    public List<Address> show(HttpSession session){
        User user = (User) session.getAttribute("user");
        return addressService.selectAll(user.getUserId());
    }


}
