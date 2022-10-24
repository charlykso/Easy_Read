import React, { useState } from 'react'
import useFetch from '../../hooks/useFetch'
import UserList from '../sub_pages/UserList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { getAllUserUrl } from "../sub_pages/BaseUrl";

const Users = () => {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const location = useLocation()
  // const token = localStorage.getItem('token')
  // const jwt = token.token

  const { data: users, isPending, error } = useFetch(getAllUserUrl)

  const searchHandler = (searchTerm) => {
    setSearchTerm(searchTerm)
    if (searchTerm !== '') {
      const newUserList = users.filter((user) => {
        return Object.values(user)
          .join(' ')
          .toLowerCase()
          .includes(searchTerm.toLowerCase())
      })
      setSearchResult(newUserList)
    } else {
      setSearchResult(users)
    }
  }

  return (
    <div className='container mx-auto md:px-8 min-h-screen'>
      {!isPending && (
        <Breadcrumbs
          location={location.pathname}
          userSearchKeyword={searchHandler}
        />
      )}
      {isPending && <Loading />}
      {error && <div>{error}</div>}
      {users && (
        <UserList
          users={searchTerm.length < 1 ? users : searchResult}
          term={searchTerm}
          searchKeyword={searchHandler}
        />
      )}
    </div>
  )
}

export default Users
