<script setup>
import { ref } from "vue";
import * as todoApi from "./todo";

// 요청 더미 데이터
// users_seq: any, categories_seq: any, title: any
const usersSeq = ref(1);
const categoriesName = ref("category1");
const title = "SomeThing Todo4";
// const title = `todo from ${usersSeq.value}, category: ${categoriesName.value}`;

// 응답 받을 변수
const responseData = ref({});

const postListTestButtonClickHandler = async () => {
  console.log("postListTestButtonClickHandler 실행");
  // console.log(usersSeq.value, categoriesName.value, title);
  responseData.value = await todoApi.postTodoListItem(
    usersSeq.value,
    categoriesName.value,
    title
  );
  // console.log(responseData.value);
};

const getListTestButtonClickHandler = async () => {
  responseData.value = await todoApi.getTodoList(usersSeq.value);
};

const getListItemTestButtonClickHandler = () => {};

const putListTestButtonClickHandler = () => {};

const deleteListTestButtonClickHandler = () => {};
</script>

<template lang="">
  <div>
    <h1>여기는 API TEST 컴포넌트입니다.</h1>
    <div>
      <button id="postListTestButton" @click="postListTestButtonClickHandler">
        postListTestButton
      </button>
    </div>
    <div>
      <button id="getListTestButton" @click="getListTestButtonClickHandler">
        getListTestButton
      </button>
    </div>
    <div>
      <button
        id="getListItemTestButton"
        @click="getListItemTestButtonClickHandler"
      >
        getListItemTestButton
      </button>
    </div>
    <div>
      <button id="putListTestButton" @click="putListTestButtonClickHandler">
        putListTestButton
      </button>
    </div>
    <div>
      <button
        id="deleteListTestButton"
        @click="deleteListTestButtonClickHandler"
      >
        deleteListTestButton
      </button>
    </div>
    <div>Response Data : {{ responseData }}</div>
  </div>
</template>

<style lang=""></style>
