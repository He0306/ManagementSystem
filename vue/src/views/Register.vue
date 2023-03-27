<template>
  <div>
    <div style="width: 500px;height: 350px;margin: 150px auto" class="box">
      <div style="text-align: center;font-size: 30px;padding: 30px">用户注册</div>
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="用户名" prop="username">
          <el-input prefix-icon="el-icon-user" v-model="ruleForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密  码" prop="password">
          <el-input prefix-icon="el-icon-lock" type="password" v-model="ruleForm.password"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirm">
          <el-input prefix-icon="el-icon-lock" type="password" v-model="ruleForm.confirm"></el-input>
        </el-form-item>
        <div class="login"><a href="/login">已有账号？去登录</a> </div>
        <el-form-item>
          <el-button type="primary" @click="register" class="btn1">注册</el-button>&nbsp;&nbsp;
        </el-form-item>
      </el-form>
    </div>
    <div style="text-align: center">网站备案号：湘ICP备2022021867号-1</div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    return {
      ruleForm: {
        username: '',
        password: '',
        confirm: ''
      },
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur'}
        ],
        confirm: [
          {required: true, message: '请在次输入密码', trigger: 'blur'},
          {min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur'}
        ],
      }
    };
  },
  methods: {
    register() {
      this.$refs['ruleForm'].validate((valid) => {
        if (valid) {
          if (this.ruleForm.password !== this.ruleForm.confirm) {
            this.$message({
              message: '两次密码不一致',
              type: "error",
              duration: 1 * 1000
            })
            return false
          }
          this.request.post("/user/register",this.ruleForm).then(res=>{
            console.log(res)
            if (res.code === '200'){
              this.$message({
                message: '注册成功',
                type: 'success',
                duration: 1*1000
              })
              this.$router.push("/")
            }else {
              this.$message({
                message: res.msg,
                type: 'error',
                duration: 1*1000
              })
            }
          })
        }
      })
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
.btn1 {
  width: 200px;
  height: 40px;
  margin-left: 50px;
  margin-top: 10px;
}
a {
  text-decoration: none;
  color: #cccccc;
  font-size: 12px;
  margin-left: 350px;
}
</style>