<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:250px" suffix-icon="el-icon-search" placeholder="请输入文章标题" v-model="name"
                clearable></el-input>
      <el-button style="margin-left: 3px" type="primary" @click="load">搜索</el-button>
      <el-button style="margin-left: 3px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 5px 0">
      <el-button type="primary" @click="handleAdd" v-if="user.role === 'ROLE_ADMIN'">新增<i
          class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm style="margin-left: 5px"
                     confirm-button-text='确定'
                     cancel-button-text='取消'
                     icon="el-icon-info"
                     icon-color="red"
                     title="您确定删除吗？"
                     @confirm="deleteBatch"
      >
        <el-button type="danger" slot="reference" v-if="user.role === 'ROLE_ADMIN'">批量删除<i
            class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
    </div>
    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="name" label="文章标题">
      </el-table-column>
      <el-table-column prop="content" label="文章内容">
        <template slot-scope="scope">
          <el-button type="primary" @click="view(scope.row.content)">查看内容</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="user" label="发布人">
      </el-table-column>
      <el-table-column prop="time" label="发布时间">
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="300">
        <template slot-scope="scope">
          <el-button type="warning" size="small" @click="handleEdit(scope.row)" v-if="user.role === 'ROLE_ADMIN'">编辑<i
              class="el-icon-edit"></i>
          </el-button>
          <el-popconfirm style="margin-left: 5px"
                         confirm-button-text='确定'
                         cancel-button-text='取消'
                         icon="el-icon-info"
                         icon-color="red"
                         title="您确定删除吗？"
                         @confirm="handleDelete(scope.row.id)"
          >
            <el-button type="danger" size="small" slot="reference" v-if="user.role === 'ROLE_ADMIN'">删除<i
                class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding-left: 400px;padding-top: 15px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5,10,15,20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>
    <!--新增和编辑弹窗-->
    <el-dialog title="文章信息" :visible.sync="dialogFormVisible" width="60%" top="10px">
      <el-form label-width="80px">
        <el-form-item label="文章标题">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="文章内容">
          <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!--  文章预览弹窗  -->
    <el-dialog title="文章详情" :visible.sync="viewDialogVisible" width="60%" top="10px">
      <!-- 预览 -->
      <mavon-editor
          class="md"
          :value="content"
          :subfield="false"
          :defaultOpen="'preview'"
          :toolbarsFlag="false"
          :editable="false"
          :scrollStyle="true"
          :ishljs="true"
      />
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Article",
  data() {
    return {
      form: {},
      tableData: [],
      name: '',
      multipleSelection: '',
      pageNum: 1,
      pageSize: 5,
      total: 0,
      headerBg: 'headerBg',
      dialogFormVisible: false,
      viewDialogVisible: false,
      teachers: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      content: ''

    }
  },
  created() {
    this.load()
  },
  methods: {
    //查看文章内容
    view(content){
      this.content = content
      this.viewDialogVisible = true
    },
    // 绑定@imgAdd event
    imgAdd(pos, $file){
      let $vm = this.$refs.md
      // 第一步.将图片上传到服务器.
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: 'http://localhost:8181/file/upload',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        // 第二步.将返回的url替换到文本原位置![...](./0) -> ![...](url)
        $vm.$img2Url(pos, res.data);
      })
    },
    //分页查询
    load() {
      this.request.get("/article/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data.records
        this.total = res.data.total
      });

    },
    //页数
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    //页码
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.load()
    },
    //新增
    save() {
      this.request.post("/article", this.form).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "保存成功",
            duration: 1 * 1000
          })
          this.load()
          this.dialogFormVisible = false
        } else {
          this.$message({
            type: "error",
            message: "保存失败",
            duration: 1 * 1000
          })
        }
      })
    },
    //搜索重置按钮
    reset() {
      this.name = ""
      this.load()
    },
    //打开新增弹窗
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },
    //编辑
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))  //深拷贝
      this.dialogFormVisible = true
    },
    //根据ID删除
    handleDelete(id) {
      this.request.delete("/article/" + id).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "删除成功",
            duration: 1 * 1000
          })
          this.load()
        } else {
          this.$message({
            type: "error",
            message: "删除失败",
            duration: 1 * 1000
          })
        }
      })
    },
    //批量删除 val:数组
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    deleteBatch() {
      let ids = this.multipleSelection.map(v => v.id)
      this.request.post("/article/delete/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "批量删除成功",
            duration: 1 * 1000
          })
          this.load()
        } else {
          this.$message({
            type: "error",
            message: "批量删除失败",
            duration: 1 * 1000
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