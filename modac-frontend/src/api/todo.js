import httpApi from "./http";

export const postTodoListItem = async (usersSeq, categoriesSeq, title) => {
  console.log(usersSeq, categoriesSeq, title);
  return await httpApi.post("/todo", { usersSeq, categoriesSeq, title });
};

export const getTodoList = async (usersSeq) => {
  return await httpApi.get("/todo/list", { params: usersSeq });
};

export const getTodoListItem = async (usersSeq) => {
  return await httpApi.get("/todo", { params: { usersSeq } });
};

export const putTodoListItem = async (
  seq, // todo's seq
  usersSeq,
  categoriesSeq,
  title,
  status,
  totalSecond
) => {
  return await httpApi.put("/todo", {
    seq,
    usersSeq,
    categoriesSeq,
    title,
    status,
    totalSecond,
  });
};

export const deleteTodoListItem = async (seq) => {
  httpApi.delete("/todo", { seq });
};
