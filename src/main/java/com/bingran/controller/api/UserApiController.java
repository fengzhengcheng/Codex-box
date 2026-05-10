package com.bingran.controller.api;

import com.bingran.annotation.OperationLog;
import com.bingran.common.Result;
import com.bingran.dto.UserSaveDTO;
import com.bingran.entity.SysUser;
import com.bingran.exception.BusinessException;
import com.bingran.service.SysUserService;
import com.bingran.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserApiController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/list")
    public Result<List<UserVO>> list() {
        List<UserVO> users = sysUserService.findAll().stream()
                .map(UserVO::fromEntity)
                .toList();
        return Result.success(users);
    }

    @GetMapping("/{id}")
    public Result<UserVO> detail(@PathVariable Long id) {
        SysUser user = sysUserService.findById(id);
        if (user == null) {
            throw new BusinessException(404, "用户不存在");
        }
        return Result.success(UserVO.fromEntity(user));
    }

    @OperationLog("保存用户")
    @PostMapping("/save")
    public Result<UserVO> save(@RequestBody UserSaveDTO dto) {
        SysUser user = sysUserService.saveFromDTO(dto);
        return Result.success(UserVO.fromEntity(user));
    }

    @OperationLog("删除用户")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        sysUserService.delete(id);
        return Result.success();
    }
}
