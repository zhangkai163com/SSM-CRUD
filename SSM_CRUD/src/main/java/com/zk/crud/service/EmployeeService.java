package com.zk.crud.service;

import com.zk.crud.bean.Employee;
import com.zk.crud.bean.EmployeeExample;
import com.zk.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
@Controller
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    EmployeeService employeeService;


    /**
     * 检查传递来的姓名是否存在,入不存在,则返回true
     * @param empName
     * @return
     */
  //empName是从indexx.jsp的443行传递来的参数,也可以用@Requestparam注解来获取
    public boolean checkUser(String empName){
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
          criteria.andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(employeeExample);
        return  l==0;
    }

    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);

    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public Employee getEmp(int id) {
      return   employeeMapper.selectByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {

        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample)


    }


    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
}
