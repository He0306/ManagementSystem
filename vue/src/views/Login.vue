<template>
  <div>
    <div style="width: 500px;height: 350px;margin: 150px auto" class="box">
      <div style="text-align: center;font-size: 30px;padding: 30px">用户登录</div>
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="用户名" prop="username">
          <el-input prefix-icon="el-icon-user" v-model="ruleForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密  码" prop="password">
          <el-input prefix-icon="el-icon-lock" type="password" show-password v-model="ruleForm.password"></el-input>
        </el-form-item>
        <div class="register"><a href="/register">免费注册</a></div>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')" class="btn">登录</el-button>&nbsp;&nbsp;
          <el-button @click="resetForm('ruleForm')" class="btn">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div style="text-align: center">网站备案号：湘ICP备2022021867号-1</div>
  </div>
</template>

<script>
import {setRoutes} from "@/router";

export default {
  name: "Login",
  data() {
    return {
      ruleForm: {
        username: '',
        password: ''
      },
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'change'},
          {min: 3, max: 15, message: '长度在 3 到 15 个字符', trigger: 'blur'}
        ],
      }
    };
  },
  methods: {
    submitForm(ruleForm) {
      this.$refs['ruleForm'].validate((valid) => {
        if (valid) {
          this.request.post("/user/login", this.ruleForm).then(res => {
            if (res.code === '200') {
              localStorage.setItem("user", JSON.stringify(res.data))  //把用户信息存在浏览器
              localStorage.setItem("menus", JSON.stringify(res.data.menus))
              localStorage.setItem("token", JSON.stringify(res.data.token))
              this.$message({
                message: '登录成功',
                type: 'success',
                duration: 1500,
              })
              //设置当前用户的路由
              setRoutes()

              if (res.data.role === 'ROLE_STUDENT'){
                this.$router.push("/front/home")
              }else {
                this.$router.push("/")
              }

            } else {
              this.$message({
                message: res.msg,
                type: 'error',
                duration: 1000
              })
            }
          })
        }else {
          this.$message({
            showClose: true,
            type: 'warning',
            message: '输入框内容不能为空',
            duration: 1000
          })
        }
      })
    },
    resetForm(formName) {
      this.$refs['ruleForm'].resetFields();
    }
  }
}
</script>

<style scoped>
.box {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)
}

.demo-ruleForm {
  width: 450px;
}

.btn {
  width: 70px;
  height: 35px;
  margin-top: 20px;
  margin-left: 50px;
}

.register {
  font-size: 10px;
  margin-left: 400px;
}

a {
  text-decoration: none;
  color: #cccccc;
}
</style>