// import { Link } from "react-router-dom";
import React from "react";
import Select from 'react-select';
import { useEffect, useState } from "react";

const Books = ({ AuthorBooks }) => {

const [newBook] = useState([])
useEffect(() => {
 if(AuthorBooks[0]){
  AuthorBooks.map((book, index) => {newBook.push({label:book.Title, value:book.Id, key: index}); return 1})
  // console.log(newBook)
 }else{
  newBook.push({label: "No book", value: 2})
 }
}, [newBook, AuthorBooks])
  return (
    <>
      <div className=' min-h-full'>
        <Select options={newBook} />
      </div>
    </>
  )
}

export default Books
