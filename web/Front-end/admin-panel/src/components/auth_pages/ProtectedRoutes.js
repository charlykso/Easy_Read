import React from 'react'
import { Outlet, Navigate } from 'react-router'
import { useAuthContext } from '../../hooks/useAuthContext'
// import useWatch from '../../hooks/useWatch'

const ProtectedRoutes = () => {
  const { user } = useAuthContext()
  // const [loggedIn, setLoggedIn] = useState()

  // useWatch(() => {
  //   if (user == null) {
  //     setLoggedIn(false)
  //   } else {
  //     setLoggedIn(true)
  //   }
  // }, [loggedIn])

  return user ? <Outlet /> : <Navigate to='/login' />
}

export default ProtectedRoutes
