import React, { useState } from 'react'
import useFetch from '../../hooks/useFetch'
import PaymentList from '../sub_pages/PaymentList'
import Loading from '../sub_pages/Loading'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { getAllPaymentUrl } from '../sub_pages/BaseUrl'

const Payments = () => {
  const [searchTerm, setSearchTerm] = useState('')
  const [searchResult, setSearchResult] = useState([])
  const location = useLocation()
  // const token = localStorage.getItem('token')
  // const jwt = token.token

  const { data: payments, isPending, error } = useFetch(getAllPaymentUrl)

  const searchHandler = (searchTerm) => {
    setSearchTerm(searchTerm)
    if (searchTerm !== '') {
      const newPaymentList = payments.filter((payment) => {
        return Object.values(payment)
          .join(' ')
          .toLowerCase()
          .includes(searchTerm.toLowerCase())
      })
      setSearchResult(newPaymentList)
    } else {
      setSearchResult(payments)
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
      {payments && (
        <PaymentList
          payments={searchTerm.length < 1 ? payments : searchResult}
          term={searchTerm}
          searchKeyword={searchHandler}
        />
      )}
    </div>
  )
}

export default Payments
