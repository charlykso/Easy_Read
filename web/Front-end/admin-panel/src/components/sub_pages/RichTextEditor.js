import React, { useRef } from 'react'
import JoditEditor from 'jodit-react'

const RichTextEditor = ({ setValue }) => {
  const editor = useRef(null)
  return (
    <JoditEditor
      className='min-h-full'
      minHeight={{ minHeight: '450px' }}
      ref={editor}
      onChange={(content) => setValue(content)}
    />
  )
}

export default RichTextEditor
