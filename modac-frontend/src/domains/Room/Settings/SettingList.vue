<template>
  <div class="setting-box">

    <!-- header -->
    <div class="setting-box-header">
      <div class="setting-box-name">방 정보 수정</div>
    </div>
    <!-- end header -->

    <!-- body -->
    <div class="setting-box-body">
      <div class="setting-box-size1">
        <div class="setting-box-size2">

          <div class="room-title">
            <div class="setting-box-content">제목</div>
            <textarea name="" id="" cols="30" rows="10">방 제목입니다.</textarea>
          </div>
          
          <div class="Room-Description">
            <div class="설명">설명</div>
            <textarea name="" id="" cols="30" rows="10">방 설명입니다.</textarea>
          </div>
          
          <div class="Room-Theme">
            <div class="테마 제목">나는 테마 제목</div>
            <div class="테마 토글">나는 테마 토글</div>
            <select name="" id="">
              <option value="modac1">모닥불1</option>
              <option value="modac2">모닥불2</option>
              <option value="modac3">모닥불3</option>
            </select>
          </div>
          
          <div class="Sound-Controller">
            
            <div class="기본 음악">
              <div class="기본 음악 제목">나는 음악 제목</div>
              <div class="기본 음악 컨트롤러">나는 음악 컨트롤러</div>
            </div>
            
            <div class="ASMR">
              <div class="ASMR 제목">나는 ASMR 제목</div>
              <div class="AMSR 컨트롤러">나는 ASMR 컨트롤러</div>
            </div>
            
          </div>
          
          <div class="Skin-Change">
            <div class="고양이">고양이</div>
            <select name="" id="">
              <option value="cat1">스킨1</option>
              <option value="cat2">스킨2</option>
              <option value="cat3">스킨3</option>
            </select>
          </div>
        </div>
      </div>
    </div>
        <!-- end body -->

    <div class="Delete-Room">
      <div class="방 삭제">방 삭제하기</div>
      <div class="삭제 버튼">나는 삭제 버튼</div>
    </div>
  
  </div>
</template>

<script setup>

</script>

<style>
@import './SettingList.css'
</style>