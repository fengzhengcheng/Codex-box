package com.aihub.service;

import com.aihub.dto.LoginDTO;
import java.util.Map;

public interface AdminService {

    String login(LoginDTO loginDTO);

    Map<String, Long> getStatistics();
}
