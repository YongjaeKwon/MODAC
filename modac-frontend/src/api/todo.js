import httpApi from "./http";

// 1단계 함수 구현
const getTodoList = async (users_seq) => {
  return await httpApi.get('/todo/list', {params: users_seq});
};

const getTodoListItem = async (users) => {
  return await httpApi.get('/todo', {params: users_seq})
}

const 

// 2단계. 함수를 객체로 모아서 export
export const todoApi = {
  getList: getTodoList,
  getItem: getTodoListItem,

}