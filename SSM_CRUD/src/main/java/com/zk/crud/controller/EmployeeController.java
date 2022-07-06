package com.zk.crud.controller;

import com.zk.crud.bean.Employee;
import com.zk.crud.bean.Msg;
import com.zk.crud.service.EmployeeService;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class EmployeeController {


    /***
     * 查询运功数据(分页)+
     * 使用@RequestParam获取传来的y页码,并绑定到形参上,如果没有则默认为1
     * @return
     */
    @RequestMapping("/emps")
    //ResponseBody可以把方法的返回值转化为json格式
    @ResponseBody
    public  Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn , Model model){

        //查询之前插入页码和条目数,实现分页

        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
//            把查询结果进行封装,实现分页
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);




    }


    @Autowired
    EmployeeService employeeService;


    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn , Model model){

        //查询之前插入页码和条目数,实现分页

        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
//            把查询结果进行封装,实现分页
        PageInfo page = new PageInfo(emps);
        //把分页后的查询结果共享给model域
        model.addAttribute("pageInfo",page);

        return "index";
    }



    @RequestMapping("/checkeruser")
    public Msg chechUser(String empName){

        //先判断用户名是否合法
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_mag","用户名不合法")
        }

        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }



    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee, HttpServletRequest request){
        System.out.println("请求体中的值："+request.getParameter("gender"));
        System.out.println("将要更新的员工数据："+employee);
        employeeService.updateEmp(employee);
        return Msg.success();

    }


    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("empId") int  id){
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp",emp);

    }


    //@ResponseBody的作用其实是将java对象转为json格式的数据。写入到response对象的body区，
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}" ,method = RequestMethod.DELETE)
    public void delEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String [] str_ids=ids.split("-");

            for (String string :str_ids){
                del_ids.add(Integer.parseInt(string));

            }
            employeeService.deleteBatch(del_ids);

        }else{
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }




    }



}
