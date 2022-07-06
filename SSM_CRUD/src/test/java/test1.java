
import com.zk.crud.bean.Department;
import com.zk.crud.dao.DepartmentMapper;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class test1 {


    @Test
    public void test1(){
        ClassPathXmlApplicationContext classPathXmlApplicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper bean = classPathXmlApplicationContext.getBean(DepartmentMapper.class);
        bean.insert(new Department(null,"开发"));
        bean.insert(new Department(null,"测试"));


    }
}
