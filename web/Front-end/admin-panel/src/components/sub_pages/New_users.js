import React from "react";
import { getAllUserUrl } from '../sub_pages/BaseUrl'
import useFetch from "../../hooks/useFetch";
import { ThreeDots } from 'react-loading-icons'


const New_users = () => {
  const { data: users, isPending, error } = useFetch(getAllUserUrl)

  var newUsers = []
  if (users) {
    var no_Of_Users = users.length - 1
    for (let index = 0; index < no_Of_Users; index++) {
      if (newUsers.length < 10) {
        newUsers.push(users[no_Of_Users])
      } else {
        break
      }
      no_Of_Users = no_Of_Users - 1
    }
    // console.log(newUsers)
  }
    return (
      <div className='right bg-gray-200 h-full pt-5 w-full rounded-lg '>
        <h3 className='text-black-700 text-2xl md:text-3xl lg:text-4xl font-bold pl-5'>
          New Users
        </h3>
        {error && <div className='text-red-600 pl-5'>{error}</div>}
        {isPending ? (
          <div className='flex justify-center p-3'>
            <p>
              <ThreeDots />
            </p>
          </div>
        ) : (
          <div className='flex justify-start p-3'>
            <ul
              className='bg-white rounded-lg w-full text-gray-900'
              id='collapseWithScrollbar'
            >
              {newUsers.map((newUser, index) => (
                <li
                  key={index}
                  className='px-6 py-2 border-b border-gray-200 w-full rounded-t-lg'
                >
                  {index + 1}. {newUser.Firstname} {newUser.Lastname}{' '}
                  {newUser.Email}
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
    )
}
 
export default New_users;