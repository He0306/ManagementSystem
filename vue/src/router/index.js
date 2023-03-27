import Vue from 'vue'
import VueRouter from 'vue-router'
import store from "@/store/index"
import Login from "@/views/Login"
import Register from "@/views/Register"

Vue.use(VueRouter)

const routes = [
    {
        path: '/login',
        name: "Login",
        component: Login
    },
    {
        path: '/register',
        name: 'Register',
        component: Register
    },
    {
        path: '/404',
        name: '404',
        component: () => import('../views/404.vue')
    },
    {
        path: '/front',
        name: 'Front',
        component: ()=> import('../views/front/Front'),
        children: [
            {
                path: 'home',
                name: 'FrontHome',
                component: ()=>import('../views/front/Home')
            },
            {
                path: 'item1',
                name: 'Item1',
                component: ()=> import('../views/front/Item1')
            },
            {
                path: 'video',
                name: 'Video',
                component: ()=> import('../views/front/Video')
            },
            {
                path: 'videoDetail',
                name: 'VideoDetail',
                component: ()=> import('../views/front/VideoDetail')
            },
            {
                path: 'article',
                name: 'Article',
                component: ()=> import('../views/front/Article')
            },
            {
                path: 'articleDetail',
                name: 'ArticleDetail',
                component: ()=> import('../views/front/ArticleDetail')
            }
        ]
    },

]
//提供一个重置路由的方法
const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

export const resetRouter = () => {
    router.matcher = new VueRouter({
        mode: 'history',
        base: process.env.BASE_URL,
        routes
    })
}

export const setRoutes = () => {
    //拼装动态路由
    const storeMenus = localStorage.getItem("menus")
    if (storeMenus) {
        const currentRouteNames = router.getRoutes().map(v => v.name)
        if (!currentRouteNames.includes('Manger')) {
            const managerRote = {
                path: '/',
                name: 'Manger',
                component: () => import("../views/Manager.vue"),
                redirect: '/home',
                children: [
                    {path: 'person', name: '个人信息', component: () => import('../views/Person.vue')},
                    {path: 'updatePwd', name: '修改密码', component: () => import('../views/UpdatePwd.vue')}
                ]
            }
            const menus = JSON.parse(storeMenus)
            menus.forEach(item => {
                if (item.path) {   //当前仅当path不为空的时候才去设置
                    let itemMenu = {
                        path: item.path.replace("/", ""),
                        name: item.name,
                        component: () => import('../views/' + item.pagePath + '.vue'),
                    }
                    managerRote.children.push(itemMenu)
                } else if (item.children.length) {
                    item.children.forEach(item => {
                        if (item.path) {   //当前仅当path不为空的时候才去设置
                            let itemMenu = {
                                path: item.path.replace("/", ""),
                                name: item.name,
                                component: () => import('../views/' + item.pagePath + '.vue'),
                            }
                            managerRote.children.push(itemMenu)
                        }
                    })
                }
            })
            //动态添加到现在的路由对象去
            router.addRoute(managerRote)
        }
    }
}
setRoutes()

//路由守卫
router.beforeEach((to, from, next) => {
    localStorage.setItem("currentPathName", to.name)  //设置路由名称
    store.commit("setPath")  //触发store的数据更新
    //未找到路由的情况
    if (!to.matched.length) {
        const storeMenus = localStorage.getItem("menus")
        if (storeMenus) {
            next("/404")
        } else {
            //跳回登录页面
            next("/login")
        }
    }
    next() //放行路由
})

export default router
