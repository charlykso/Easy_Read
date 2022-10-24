import useFetch from '../../hooks/useFetch'
import BooksList from '../sub_pages/BooksList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import React, { useState } from 'react'
import { getAllBooksUrl } from '../sub_pages/BaseUrl'

const Books = () => {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const location = useLocation()
  const { data: books, isPending, error } = useFetch(getAllBooksUrl)

  const searchHandler = (searchTerm) => {
    setSearchTerm(searchTerm)
    if (searchTerm !== '') {
      const newBookList = books.filter((book) => {
        return Object.values(book)
          .join(' ')
          .toLowerCase()
          .includes(searchTerm.toLowerCase())
      })
      setSearchResult(newBookList)
    } else {
      setSearchResult(books)
    }
  }
  return (
    <div className='container mx-auto md:px-8'>
      {!isPending && (
        <Breadcrumbs
          location={location.pathname}
          searchKeyword={searchHandler}
        />
      )}
      {isPending && <Loading />}
      {error && <div className='text-red-600'>{error}</div>}
      {books && (
        <BooksList
          books={searchTerm.length < 1 ? books : searchResult}
          term={searchTerm}
          searchKeyword={searchHandler}
        />
      )}
    </div>
  )
}

export default Books
