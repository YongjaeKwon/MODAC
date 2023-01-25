import httpApi from "./http";

export const postTodoListItem = async (usersSeq, categoriesName, title) => {
  return await httpApi.post("/todos", { usersSeq, categoriesName, title });
};

export const getTodoList = async (usersSeq) => {
  return await httpApi.get("/todos/", { params: { usersSeq } });
};

export const getTodoListItem = async (usersSeq) => {
  return await httpApi.get("/todos", { params: { usersSeq } });
};

export const putTodoListItem = async (
  seq, // todo's seq
  usersSeq,
  categoriesSeq,
  title,
  status,
  totalSecond
) => {
  return await httpApi.put("/todos", {
    seq,
    usersSeq,
    categoriesSeq,
    title,
    status,
    totalSecond,
  });
};

export const deleteTodoListItem = async (seq) => {
  httpApi.delete("/todos", { seq });
};
