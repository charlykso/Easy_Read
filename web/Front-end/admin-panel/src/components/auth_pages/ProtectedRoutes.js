import React from 'react'
import { Outlet, Navigate } from "react-router";
import { useAuthContext } from '../../hooks/useAuthContext'


const ProtectedRoutes = () => {
    const { user } = useAuthContext()
    
  return user ? <Outlet /> : <Navigate to='/login' />
}

export default ProtectedRoutes