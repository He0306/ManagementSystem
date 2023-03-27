<template>
  <div style="margin-top:20px">
    <div class="pd-10" style="font-size: 20px;color: #1E90FF;cursor: pointer">{{ article.name }}</div>
    <div style="font-size: 14px;margin-top: 15px;margin-bottom: 15px">
      <i class="el-icon-user-solid"><span>{{ article.user }}</span></i>
      <i class="el-icon-time" style="margin-left: 10px"><span>{{ article.time }}</span></i>
    </div>
    <div style="margin-bottom: 20px">
      <!-- 预览 -->
      <mavon-editor
          class="md"
          :value="article.content"
          :subfield="false"
          :defaultOpen="'preview'"
          :toolbarsFlag="false"
          :editable="false"
          :scrollStyle="true"
          :ishljs="true"
      />
    </div>

    <div style="margin: 30px 0;">
      <div style="margin: 10px 0">
        <div style="border-bottom: 1px solid orangered;font-size: 20px">评论</div>
        <div style="padding: 10px 0">
          <el-input type="textarea" v-model="commentForm.content"></el-input>
        </div>
        <div class="pd-10" style="text-align: right">
          <el-button type="primary" size="small" @click="save">评论</el-button>
        </div>
      </div>


      <!--  评论列表  一级 -->
      <div>
        <div v-for="item in comments" :key="item.id" style="border-bottom: 1px solid #ccc; padding: 10px 0">
          <!--   头像     -->
          <div style=";display: flex">
            <div style="width: 100px;text-align: center">
              <el-image :src="item.avatar" style="width: 50px;height: 50px;border-radius: 50%"></el-image>
            </div>
            <!--    内容    -->
            <div style="flex: 1;font-size: 14px;padding: 10px 0;line-height: 25px">
              <b>{{ item.nickname }}：</b>
              <span>{{ item.content }}</span>
              <!-- 回复列表 -->
              <div style="display: flex;line-height: 5px;margin-top: 5px">
                <div style="width: 200px">
                  <i class="el-icon-time"><span style="margin-left: 5px">{{ item.time }}</span></i>
                </div>
                <div style="text-align: right;flex: 1;">
                  <el-button style="margin-left: 5px;" type="text" @click="handleReply(item.id)">回复</el-button>
                  <el-button style="color: red;" type="text" @click="handleDelete(item.id)"
                             v-if="user.id === item.userId">删除
                  </el-button>
                </div>
              </div>
            </div>
          </div>

          <!--    二级评论      -->
          <div v-if="item.children.length" style="padding-left: 100px">
            <div v-for="subItem in item.children" :key="subItem.id"
                 style="background-color: #f0f0f0">
              <div style="font-size: 14px;padding: 5px 0;line-height: 25px">
                <div style="margin-left: 10px">
                  <b style="color: #3a8ee6" v-if="subItem.pnickName">@{{ subItem.pnickName }}</b>
                </div>
                <div style="padding-left: 10px">
                  <b>{{ subItem.nickname }}：</b>
                  <span>{{ subItem.content }}</span>
                </div>
                <!-- 回复列表 -->
                <div style="display: flex;line-height: 10px;margin-left: 10px">
                  <div style="width: 200px">
                    <i class="el-icon-time"><span style="margin-left: 5px">{{ subItem.time }}</span></i>
                  </div>
                  <div style="text-align: right;flex: 1;">
                    <el-button style="margin-left: 5px;" type="text" @click="handleReply(subItem.id)">回复</el-button>
                    <el-button style="color: red;" type="text" @click="handleDelete(subItem.id)"
                               v-if="user.id === subItem.userId">删除
                    </el-button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--新增和编辑弹窗-->
    <el-dialog title="回复" :visible.sync="dialogFormVisible" width="40%">
      <el-form label-width="80px">
        <el-form-item label="回复评论">
          <el-input type="textarea" v-model="commentForm.contentReply" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="save" size="small">确 定</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>


export default {
  name: "Article",
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      article: {},
      headerBg: 'headerBg',
      comments: [],
      commentForm: {},
      id: this.$route.query.id,
      dialogFormVisible: false
    }
  },
  created() {
    this.load()
    this.loadComment()
  },
  methods: {
    //回复评论
    handleReply(pid) {
      this.dialogFormVisible = true
      this.commentForm = {pid: pid}

    },
    //查询文章内容
    load() {
      this.request.get("/article/" + this.id).then(res => {
        console.log(res)
        this.article = res.data
      });
    },
    //查询评论
    loadComment() {
      this.request.get("/comment/tree/" + this.id).then(res => {
        console.log(res)
        this.comments = res.data
      })
    },
    //评论
    save() {
      if (!this.user.id) {
        this.$message({
          type: "warning",
          message: "请登录后在评论",
        })
        return
      }
      this.commentForm.articleId = this.id
      if (this.commentForm.contentReply) {
        this.commentForm.content = this.commentForm.contentReply
      }
      this.request.post("/comment", this.commentForm).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "评论成功",
            duration: 1000
          })
          this.dialogFormVisible = false
          this.commentForm = {}
          this.loadComment()
        } else {
          this.$message({
            type: "error",
            message: "评论成功",
            duration: 1000
          })
        }
      })
    },
    //根据ID删除评论
    handleDelete(id) {
      this.request.delete("/comment/" + id).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "删除成功",
            duration: 1000
          })
          this.loadComment()
        } else {
          this.$message({
            type: "error",
            message: "删除失败",
            duration: 1000
          })
        }
      })
    },
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>